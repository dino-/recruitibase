import qualified Data.ByteString.Char8 as C8
import System.Directory ( getHomeDirectory )
import System.FilePath ( (</>), (<.>) )

import Recruiter ( encodePretty, loadDatabase, recrConfig )


recruitibasePath :: IO FilePath
recruitibasePath = do
  homeDir <- getHomeDirectory
  return $ homeDir </> ".config" </> "recruitibase" <.> "yaml"


main :: IO ()
main = do
  -- Loading data in
  database <- loadDatabase =<< recruitibasePath

  -- Writing it back out
  let recoded = encodePretty recrConfig <$> database
  either print C8.putStrLn recoded
