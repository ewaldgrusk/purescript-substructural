module Data.Array.Sub
  ( UniqueArray
  , empty
  , singleton
  , snoc
  , reverse
  ) where

import Data.Function.Sub (class Clone, class Drop, type (-*), clone, drop)
import Data.Tuple (Tuple(..), fst, snd)
import Prelude

--------------------------------------------------------------------------------

-- | An array that has at most one live reference to it.
foreign import data UniqueArray :: Type -> Type

instance cloneUniqueArray :: (Clone a) => Clone (UniqueArray a) where
  clone = cloneUniqueArrayFFI clone Tuple fst snd

instance dropUniqueArray :: (Drop a) => Drop (UniqueArray a) where
  drop = dropUniqueArrayFFI drop

-- | O(1) memory. O(1) time. The empty array.
foreign import empty :: ∀ a. Unit -* UniqueArray a

-- | O(1) memory, O(1) time. A singleton array.
foreign import singleton :: ∀ a. a -* UniqueArray a

-- | O(1) memory, O(1) time. Append an element to an array.
foreign import snoc :: ∀ a. UniqueArray a -> a -> UniqueArray a

-- | O(1) memory, O(n) time. Reverse an array.
foreign import reverse :: ∀ a. UniqueArray a -* UniqueArray a

--------------------------------------------------------------------------------

foreign import cloneUniqueArrayFFI
  :: ∀ a
   . (a -* Tuple a a)
  -> (∀ l r. l -> r -> Tuple l r)
  -> (∀ l r. Tuple l r -> l)
  -> (∀ l r. Tuple l r -> r)
  -> UniqueArray a
  -* Tuple (UniqueArray a) (UniqueArray a)

foreign import dropUniqueArrayFFI
  :: ∀ a
   . (a -* Unit)
  -> UniqueArray a
  -* Unit
