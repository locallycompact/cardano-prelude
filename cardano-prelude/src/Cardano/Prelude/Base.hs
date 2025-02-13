{-# LANGUAGE CPP #-}
{-# LANGUAGE FlexibleInstances #-}
{-# LANGUAGE StandaloneKindSignatures #-}
{-# LANGUAGE Safe #-}

module Cardano.Prelude.Base
  ( module X
  , identity
  , putTextLn
  , length
  , C.toS
  )
where

import Protolude as X
  hiding ( Hashable
  , Map
  , toS
  , hash
  , hashUsing
  , hashWithSalt
  , identity
  , length
  , witness
  , (.)
  )
import qualified Protolude as Y
import qualified Protolude.Conv as C

import Data.Map.Strict as X (Map)
import qualified Data.Text as T

import Control.Category (id)
import Control.Category as X hiding (id)
#if !MIN_VERSION_base(4,16,0)
import Data.Kind (Type)
#endif
import Numeric.Natural as X

-- | Rename `id` to `identity` to allow `id` as a variable name
identity :: Category cat => cat a a
identity = id

-- | Explicit output with @Text@ since that is what we want most of the time.
-- We don't want to look at the type errors or warnings arising.
putTextLn :: Text -> IO ()
putTextLn = putStrLn

-- Length which includes @Text@ as well as @Foldable@.
type HasLength :: Type -> Constraint
class HasLength a where
    length' :: a -> Int

instance HasLength Text where
  length' = T.length

instance Foldable t => HasLength (t a) where
  length' = Y.length

-- | We can pass several things here, as long as they have length.
length :: HasLength a => a -> Int
length = length'
