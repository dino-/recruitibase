module Recruiter
  ( Recruiter (..)
  , recrConfig
  , loadDatabase

  -- re-exporting
  , encodePretty
  ) where

import Data.Aeson ( FromJSON, ToJSON )
import Data.ByteString ( readFile )
import Data.Map ( Map )
import Data.Text ( Text )
import Data.Yaml ( decodeEither', prettyPrintParseException )
import Data.Yaml.Pretty ( Config, defConfig, encodePretty, setConfCompare )
import GHC.Generics ( Generic )
import Prelude hiding ( readFile )
import System.Exit ( exitFailure )


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


loadDatabase :: FilePath -> IO [Recruiter]
loadDatabase recruitibasePath = do
  loadResult <- decodeEither' <$> readFile recruitibasePath
  case loadResult of
    Left pe -> do
      putStrLn $ prettyPrintParseException pe
      exitFailure
    Right db -> return db


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
