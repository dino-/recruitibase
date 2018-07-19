module Dump
  ( doDump
  )
  where

import qualified Data.ByteString.Char8 as C8

import Common ( recruitibasePath )
import Recruiter ( encodePretty, loadDatabase, recrConfig )


doDump :: IO ()
doDump = do
  -- Load the data
  database <- loadDatabase =<< recruitibasePath
  let recoded = encodePretty recrConfig database
  C8.putStrLn recoded
