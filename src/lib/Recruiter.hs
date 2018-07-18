module Recruiter
  ( Recruiter (..)
  , decodeEither'
  , recrConfig

  -- re-exporting
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
  , active :: Bool
  , notes :: [Note]
  }
  deriving (Generic, Show)

instance FromJSON Recruiter
instance ToJSON Recruiter


decodeEither' :: ByteString -> Either Y.ParseException [Recruiter]
decodeEither' = Y.decodeEither'


data FieldOrder
  = GivenName
  | Surname
  | Company
  | Address
  | Phone
  | Email
  | Web
  | Active
  | Notes
  | Undefined
  deriving (Eq, Ord)


toFieldOrder :: Text -> FieldOrder
toFieldOrder "givenName" = GivenName
toFieldOrder "surname" = Surname
toFieldOrder "company" = Company
toFieldOrder "address" = Address
toFieldOrder "phone" = Phone
toFieldOrder "email" = Email
toFieldOrder "web" = Web
toFieldOrder "active" = Active
toFieldOrder "notes" = Notes
toFieldOrder _ = Undefined


recrConfig :: Config
recrConfig = setConfCompare (\t u -> compare (toFieldOrder t) (toFieldOrder u)) defConfig
