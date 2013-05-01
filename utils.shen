(define with-key
  { (list (A * B)) --> A --> (B --> B) --> (list (A * B)) }
  [(@p K V) | KVs] K F -> (append [(@p K (F V))] (with-key KVs K F))
  [KV | KVs] K F       -> (append [KV]           (with-key KVs K F))
  [] K F               -> [])

(define merge-alists
  { (list (A * B)) --> (list (A * B)) --> (B --> B --> B) --> (list (A * B)) }
  As Bs F -> (merge-alists Bs As F) where (< (length As) (length Bs))
  As Bs F -> (merge-alists-h As Bs F))

(define merge-alists-h
  {(list (A * B)) --> (list (A * B)) --> (B --> B --> B) --> (list (A * B)) }
  As [] F -> As
  As [KV | Bs] F -> (merge-alists-h (add-or-merge-pair As KV F) Bs F))

(define add-or-merge-pair
  {(list (A * B)) --> (A * B) --> (B --> B --> B) --> (list (A * B)) }
  [] KV F -> [KV]
  [(@p K V1) | KVs] (@p K V2) F
     -> (append [(@p K (F V1 V2))] KVs)
  [KV | KVs] ToMerge F -> (append [KV] (add-or-merge-pair KVs ToMerge F)))

(define compose
  {(list (A --> A)) --> A --> A}
  [] X -> X
  [F | Fs] X -> (compose Fs (F X)))

(define with-lookup
  { A --> (list (A * B)) --> (B --> C) --> C --> C}
  X [] F ErrV -> ErrV
  X [(@p X Y) | _] F ErrV -> (F Y)
  X [_ | Y] F ErrV -> (with-lookup X Y F ErrV))

(define every
  {(list A) --> (A --> boolean) --> boolean}
  []       F -> false
  [A]      F -> (F A)
  [A | As] F -> (and (F A) (every As F))
 )

(define elements?
  {(list A) --> (list A) --> boolean}
  As Bs -> (every As (/. A (element? A Bs)))
  )

(define show-alist-h
  { (list (A * B)) --> string --> string }
  [(@p K V) | Is] Accum -> (show-alist-h Is (@s Accum (make-string "~A ~A~%" K V)))
  [] ""    -> "No contents"
  [] Accum -> Accum)

(define show-alist
  { (list (A * B)) --> string }
  Alist -> (show-alist-h Alist ""))
