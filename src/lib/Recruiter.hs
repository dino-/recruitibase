module Recruiter
  ( Recruiter (..)
  , decodeEither'
  ) where

import Data.Aeson
import Data.ByteString
import Data.Text
import qualified Data.Yaml as Y
import GHC.Generics


data Recruiter = Recruiter
  { firstName :: Text
  , surname :: Maybe Text
  , co :: Maybe Text
  , addr1 :: Maybe Text
  , csz :: Maybe Text
  , phone :: Maybe Text
  , email :: Maybe Text
  , web :: Maybe Text
  , kind :: Maybe Text
  , active :: Bool
  , notes :: Text
  }
  deriving (Generic, Show)

instance FromJSON Recruiter


decodeEither' :: ByteString -> Either Y.ParseException [Recruiter]
decodeEither' = Y.decodeEither'
