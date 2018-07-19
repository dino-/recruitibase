module Options
  ( ActiveSel (..), Command (..), Options (..)
  , parseOpts
  )
  where

import Data.Version ( showVersion )
import qualified Options.Applicative as O
import Paths_recruitibase ( version )

import Common ( recruitibasePath )


data ActiveSel = Active | All

data Command
  = Dump
  | MailingList { cmdActiveSel :: ActiveSel }

data Options = Options
  { optDbPath :: FilePath
  , optCommand :: Command
  }


parseActiveSel :: O.Parser ActiveSel
parseActiveSel = O.flag Active All $
  O.long "all" <>
  O.help "Extract all emails from the database, not just the active ones"


parseDump :: O.Parser Command
parseDump = pure Dump


parseMailingList :: O.Parser Command
parseMailingList = MailingList <$> parseActiveSel


parseDbPath :: FilePath -> O.Parser FilePath
parseDbPath defaultDbPath = O.strOption $
  O.long "dbpath" <>
  O.short 'd' <>
  O.help "Path to the YAML database file" <>
  O.showDefault <>
  O.value defaultDbPath <>
  O.metavar "PATH"


parseCommand :: O.Parser Command
parseCommand = O.subparser $
  O.command "mailinglist" (parseMailingList `withInfo`
    "Produce a mailing list") <>
  O.command "dump" (parseDump `withInfo`
    "Dump entire database to stdout as YAML")



parseOptions :: FilePath -> O.Parser Options
parseOptions defaultDbPath = Options <$> parseDbPath defaultDbPath <*> parseCommand


parseOpts :: IO Options
parseOpts = do
  defaultDbPath <- recruitibasePath
  O.execParser $ parseOptions defaultDbPath `withInfo`
    "Extraction and viewing of the YAML recruiters 'database'"


-- Convenience function to add --help support to anything
withInfo :: O.Parser a -> String -> O.ParserInfo a
withInfo parser desc = O.info (O.helper <*> parser) $ O.progDesc desc <> O.fullDesc <> commonFooter


commonFooter :: O.InfoMod a
commonFooter = O.footer . unlines $
  [ "Version " ++ (showVersion version) ++ " Dino Morelli <dino@ui3.info>"
  ]
