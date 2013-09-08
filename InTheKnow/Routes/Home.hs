{-# LANGUAGE OverloadedStrings #-}

module InTheKnow.Routes.Home (routes) where

import qualified InTheKnow.Routes.Home.Templates as Template
import InTheKnow.Types
import Web.Scotty.Blaze (blaze)
import Web.Scotty

index :: ItkM ()
index = do
  r <- renderer
  liftScotty $ get "/" (r "Home" Template.index)

routes = index
