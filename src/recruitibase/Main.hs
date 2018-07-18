import qualified Data.ByteString as BS

import Recruiter


main :: IO ()
main = do
  contents <- BS.readFile "/home/dino/doc/jobs/recruiters.yaml"
  let result = decodeEither' contents
  print result
