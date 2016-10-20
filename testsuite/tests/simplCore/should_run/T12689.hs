data T1 = MkT1Bad                     | MkT1Good                     deriving Show
data T2 = MkT2Bad Int                 | MkT2Good Int                 deriving Show
data T3 = MkT3Bad {-# UNPACK #-} !Int | MkT3Good {-# UNPACK #-} !Int deriving Show
data T4 = MkT4Bad Int                 | MkT4Good Int                 deriving Show
data T5 = MkT5Bad {-# UNPACK #-} !Int | MkT5Good {-# UNPACK #-} !Int deriving Show
data T7 = MkT7Bad Int                 | MkT7Good Int                 deriving Show

{-# RULES

"T1"           MkT1Bad   = MkT1Good
"T2" forall x. MkT2Bad x = MkT2Good x
"T3" forall x. MkT3Bad x = MkT3Good x
"T4"           MkT4Bad   = MkT4Good
"T5"           MkT5Bad   = MkT5Good
"T7" [1] forall x. MkT7Bad x = MkT7Good x
  #-}

app = id
{-# NOINLINE app #-}

myPrint :: Show a => a -> IO ()
myPrint = print
{-# NOINLINE myPrint #-}

main = do
  myPrint MkT1Bad
  myPrint (MkT2Bad 42)
  myPrint (MkT3Bad 42)
  myPrint (MkT4Bad 42)
  myPrint (app MkT4Bad 42)
  myPrint (MkT5Bad 42)
  myPrint (app MkT5Bad 42)
  myPrint (MkT7Bad 42) -- late rule