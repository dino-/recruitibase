--import qualified Data.ByteString.Char8 as C8

import MailingList ( doMailingList )
import Options ( Options (MailingList), parseOpts )
--import Recruiter ( encodePretty, loadDatabase, recrConfig )


main :: IO ()
main = do
  options <- parseOpts
  case options of
    MailingList mlo -> doMailingList mlo
{-
  print options

  -- Loading data in
  database <- loadDatabase =<< recruitibasePath
-}

  {- This is going to be the 'dump' command in the future
  -- Writing it back out
  let recoded = encodePretty recrConfig <$> database
  --either print C8.putStrLn recoded

  let recoded = encodePretty recrConfig database
  C8.putStrLn recoded
  -}

--  return ()
