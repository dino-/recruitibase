import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as C8

import Recruiter


main :: IO ()
main = do
  -- Loading data in
  contents <- BS.readFile "/home/dino/doc/jobs/recruiters.yaml"
  let result = decodeEither' contents
  --print result

  -- Writing it back out
  let recoded = encodePretty defConfig <$> result
  either print C8.putStrLn recoded
