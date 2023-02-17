# tuple-fields

Accessing tuple fields in Haskell using record dot syntax.

Adds (orphan) typeclass instances of the following form for all tuples up to 62-tuples:

```haskell
instance HasField "_1" (a1,a2,a3) a1 where
  getField (x,_,_) = x

instance HasField "_2" (a1,a2,a3) a2 where
  getField (_,x,_) = x

instance HasField "_3" (a1,a2,a3) a3 where
  getField (_,_,x) = x
```

This allows access to all fields using record dot syntax:

```haskell
(true, "hello", 42)._1 == true
(true, "hello", 42)._2 == "hello"
(true, "hello", 42)._3 == 42
```