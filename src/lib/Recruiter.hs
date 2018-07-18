module Recruiter
  ( Recruiter (..)
  , decodeEither'

  -- re-exporting
  , defConfig
  , encodePretty
  ) where

import Data.Aeson
import Data.ByteString
import Data.Map
import Data.Text
import qualified Data.Yaml as Y
import Data.Yaml.Pretty
import GHC.Generics


newtype Note = Note (Map Text Text)
  deriving (Generic, Show)

instance FromJSON Note
instance ToJSON Note


data Recruiter = Recruiter
  { givenName :: Text
  , surname :: Maybe Text
  , company :: Maybe Text
  , address :: Maybe Text
  , phone :: Maybe Text
  , email :: Maybe Text
  , web :: Maybe Text
  , kind :: Maybe Text
  , active :: Bool
  , notes :: [Note]
  }
  deriving (Generic, Show)

instance FromJSON Recruiter
instance ToJSON Recruiter


decodeEither' :: ByteString -> Either Y.ParseException [Recruiter]
decodeEither' = Y.decodeEither'
