module MailingList
  ( doMailingList
  )
  where

import Data.Maybe ( isJust )
import Data.Text ( Text, concat, intercalate, unpack )
import Prelude hiding ( concat )
import System.IO ( hPutStrLn, stderr )

import Options ( ActiveSel (Active, All), Command (MailingList), Options (..) )
import Recruiter ( Recruiter (active, email, givenName, surname),
  loadDatabase )


doMailingList :: Options -> IO ()

doMailingList (Options dbPath (MailingList activeSel)) = do
  -- Load the data
  database <- loadDatabase dbPath

  -- Filter out any without email addresses
  let withEmail = filter (isJust . email) database

  -- Filter based on activeSel
  let active' = case activeSel of
        Active -> filter active withEmail
        All -> withEmail

  -- Format them into "givenName surname <email>" shape
  let emailStrings = map formatIntoEmail active'

  hPutStrLn stderr $ "INFO: Number of email addresses: " ++ (show . length $ emailStrings)
  hPutStrLn stderr ""

  -- Combine with commas
  let withCommas = intercalate ", " emailStrings

  -- Print
  putStrLn . unpack $ withCommas

doMailingList _ = undefined


formatIntoEmail :: Recruiter -> Text
formatIntoEmail recr = concat [givenName recr, " ", surname', email']
  where
    surname' = maybe "" (\t -> concat [t, " "]) $ surname recr
    email' = maybe "" (\t -> concat ["<", t, ">"]) $ email recr
