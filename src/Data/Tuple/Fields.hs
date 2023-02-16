{-# LANGUAGE DataKinds #-}
{-# OPTIONS_GHC -Wno-orphans #-}
{-# LANGUAGE InstanceSigs #-}

module Data.Tuple.Fields () where

import Data.Tuple
import GHC.Records ( HasField(..) )

instance HasField "_1" (Solo a) a where
  getField (Solo x) = x

instance HasField "_1" (a,b) a where
  getField :: (a, b) -> a
  getField (x,_) = x

instance HasField "_2" (a,b) b where
  getField :: (a, b) -> b
  getField (_,x) = x
