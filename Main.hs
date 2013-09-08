
module Main (main) where

import qualified InTheKnow.Routes.Common.Templates as CommonTemplates

import InTheKnow.Routes (routes)
import InTheKnow.Types (toScotty, ItkConfig(..))
import Web.Scotty (scotty)

defaultConfig = ItkConfig $ CommonTemplates.base

toScotty' = toScotty defaultConfig

main = scotty 3000 (toScotty' routes)
