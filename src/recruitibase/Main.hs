import qualified Data.ByteString as BS
import qualified Data.ByteString.Char8 as C8

import Recruiter ( encodePretty, recrDecodeEither, recrConfig )


main :: IO ()
main = do
  -- Loading data in
  contents <- BS.readFile "/home/dino/doc/jobs/recruiters.yaml"
  let result = recrDecodeEither contents
  --print result

  -- Writing it back out
  let recoded = encodePretty recrConfig <$> result
  either print C8.putStrLn recoded
