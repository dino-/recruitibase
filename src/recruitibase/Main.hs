import Dump ( doDump )
import MailingList ( doMailingList )
import Options ( Options (Dump, MailingList), parseOpts )


main :: IO ()
main = do
  options <- parseOpts
  case options of
    Dump -> doDump
    MailingList mlo -> doMailingList mlo
