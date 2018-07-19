module MailingList
  ( doMailingList
  )
  where

import Data.Maybe ( isJust )
import Data.Text ( Text, concat, intercalate, unpack )
import Prelude hiding ( concat )
import System.IO ( hPutStrLn, stderr )

import Common ( recruitibasePath )
import Options ( ActiveSel (Active, All), MailingListOptions (..) )
import Recruiter ( Recruiter (active, email, givenName, surname),
  loadDatabase )


doMailingList :: MailingListOptions -> IO ()
doMailingList (MailingListOptions activeSel) = do
  -- Load the data
  database <- loadDatabase =<< recruitibasePath

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

  return ()


formatIntoEmail :: Recruiter -> Text
formatIntoEmail recr = concat [givenName recr, " ", surname', email']
  where
    surname' = maybe "" (\t -> concat [t, " "]) $ surname recr
    email' = maybe "" (\t -> concat ["<", t, ">"]) $ email recr
