module Options
  ( ActiveSel (..), MailingListOptions (..), Options (..)
  , parseOpts
  )
  where

import Data.Version ( showVersion )
import Options.Applicative ( InfoMod, Parser, ParserInfo, command, execParser,
  flag, footer, fullDesc, help, helper, info, long, progDesc, subparser )
import Paths_recruitibase ( version )


data ActiveSel = Active | All


data MailingListOptions = MailingListOptions
  { activeSel :: ActiveSel
  }


data Options
  = MailingList MailingListOptions


parseActiveSel :: Parser ActiveSel
parseActiveSel = flag Active All $
  long "all" <>
  help "Extract all emails from the database, not just the active ones"


parseMailingList :: Parser Options
parseMailingList = MailingList <$> (MailingListOptions <$> parseActiveSel)


parseOpts :: IO Options
parseOpts = execParser $ parseCommand `withInfo`
  "Extraction and viewing of the YAML recruiters 'database'"

  where
    parseCommand = subparser $
      command "mailinglist" (parseMailingList `withInfo`
        "Produce a mailing list")


-- Convenience function to add --help support to anything
withInfo :: Parser a -> String -> ParserInfo a
withInfo parser desc = info (helper <*> parser) $ progDesc desc <> fullDesc <> commonFooter


commonFooter :: InfoMod a
commonFooter = footer . unlines $
  [ "Version " ++ (showVersion version) ++ "  Dino Morelli <dino@ui3.info>"
  ]
