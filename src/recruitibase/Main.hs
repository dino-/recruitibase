import Dump ( doDump )
import MailingList ( doMailingList )
import Options ( Command (Dump, MailingList), Options (..), parseOpts )


main :: IO ()
main = do
  options@(Options _ command) <- parseOpts
  case command of
    Dump -> doDump options
    MailingList _ -> doMailingList options
