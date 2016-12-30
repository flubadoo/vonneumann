# vonneumann

Simple Von Neumann Machine simulator made using Scheme/Racket.
Input should be in the format of:

```
(define prog2
  '((start: input val)
    (load val)
    (skipzero)
    (jump continue)
    (halt)
    (continue: storei pointer)
    (load pointer)
    (add one)
    (store pointer)
    (jump start)
    (one: data 1)
    (val: data 0)
    (pointer: data table)
    (table: data 0)))
```

And running the procedure assemble on this yields:

```
(assemble prog2 0) =>
 '((0 1 0 1 0 0 0 0 0 0 0 0 1 0 1 1) 
  (0 0 0 1 0 0 0 0 0 0 0 0 1 0 1 1) 
  (1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) 
  (0 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1) 
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) 
  (1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0) 
  (0 0 0 1 0 0 0 0 0 0 0 0 1 1 0 0) 
  (0 0 1 1 0 0 0 0 0 0 0 0 1 0 1 0) 
  (0 0 1 0 0 0 0 0 0 0 0 0 1 1 0 0) 
  (0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0) 
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1) 
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0) 
  (0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1) 
  (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
```

And then when we have a config:

```
(define config1
 '((acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) 
  (pc (0 0 0 0 0 0 0 0 0 0 0 0)) 
  (run-flag 1) 
  (aeb 0) 
  (0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1)) 
  (1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0)) 
  (2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) 
  (3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)) 
  (4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))))
```

> (simulate config1 2)

```
(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(pc (0 0 0 0 0 0 0 0 0 0 0 0))
(run-flag 1)
(aeb 0)
(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))
(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))
(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))

(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(pc (0 0 0 0 0 0 0 0 0 0 0 1))
(run-flag 1)
(aeb 0)
(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))
(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))
(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))

(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(pc (0 0 0 0 0 0 0 0 0 0 1 0))
(run-flag 1)
(aeb 0)
(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))
(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))
(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))
(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))
(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))

'steps-exhausted
```

Cool Stuff  
