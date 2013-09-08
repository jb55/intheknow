
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses #-}

module InTheKnow.Types where

import Data.Text (Text)
import Web.Scotty (ScottyM, ActionM)
import Web.Scotty.Blaze (blaze)
import Text.Blaze.Html (Html)
import Control.Monad.Reader (ReaderT, ask, MonadReader, runReaderT)
import Control.Monad.Trans (lift)
import Control.Applicative

type BaseRenderer = Text -> Html -> Html

data ItkConfig = ItkConfig { configRender :: BaseRenderer }

newtype ItkM a = ItkM { runItk :: ReaderT ItkConfig ScottyM a }
               deriving (Monad, Functor, MonadReader ItkConfig)


class Monad m => MonadScotty m where
  liftScotty :: ScottyM a -> m a

instance MonadScotty ItkM where
  liftScotty = ItkM . lift

toScotty :: ItkConfig -> ItkM a -> ScottyM a
toScotty c m = runReaderT (runItk m) c

renderer :: ItkM (Text -> Html -> ActionM ())
renderer = renderer' . configRender <$> ask

renderer' :: BaseRenderer -> Text -> Html -> ActionM ()
renderer' r t h = blaze (r t h)
