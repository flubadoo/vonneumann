<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN" "http://www.w3.org/TR/html4/strict.dtd">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  <meta http-equiv="Content-Style-Type" content="text/css">
  <title></title>
  <meta name="Generator" content="Cocoa HTML Writer">
  <meta name="CocoaVersion" content="1504.6">
  <style type="text/css">
    p.p1 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica}
    p.p2 {margin: 0.0px 0.0px 0.0px 0.0px; font: 12.0px Helvetica; min-height: 14.0px}
    span.Apple-tab-span {white-space:pre}
  </style>
</head>
<body>
<p class="p1">#lang racket</p>
<p class="p2"><br></p>
<p class="p1">; Procedures for lookup</p>
<p class="p2"><br></p>
<p class="p1">(define left-lookup</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (val table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? table) #f)</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? val (first (first table))) (first (rest (first table))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (left-lookup val (rest table)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define right-lookup</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (val table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? table) #f)</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? val (first (rest (first table)))) (first (first table)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (right-lookup val (rest table)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">; Entry update procedures</p>
<p class="p2"><br></p>
<p class="p1">(define update</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (new-entry table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? new-entry) table)</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (left-lookup (first new-entry) table) #f) (append table (list new-entry)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (first new-entry) (first (first table))) (cons new-entry (rest table)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (cons (first table) (update new-entry (rest table))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define updates</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? lst) table)</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (updates (rest lst) (update (first lst) table)))</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p1">)</p>
<p class="p2"><br></p>
<p class="p1">; (extract i j lst)<span class="Apple-converted-space"> </span></p>
<p class="p1">; takes a list lst and nonnegative integers i and j</p>
<p class="p1">; and returns the list of elements indexed i through j</p>
<p class="p1">; As in list-ref, list elements are indexed from 0.</p>
<p class="p2"><br></p>
<p class="p1">; (fill n lst)</p>
<p class="p1">; takes a nonnegative integer n and a list lst,</p>
<p class="p1">; and if n is greater than the length of lst, returns</p>
<p class="p1">; a list equal to lst with enough 0's added at the</p>
<p class="p1">; beginning to make the length of the list n.</p>
<p class="p1">; If n is less than or equal to the length of lst,</p>
<p class="p1">; it is returned as is</p>
<p class="p2"><br></p>
<p class="p1">(define drop-last</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst times)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(if (&gt; times 0)</p>
<p class="p1"><span class="Apple-converted-space">        </span>(drop-last (reverse (rest (reverse lst))) (- times 1))</p>
<p class="p1"><span class="Apple-converted-space">        </span>lst</p>
<p class="p1"><span class="Apple-converted-space">        </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define drop-first</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst times)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(if (&gt; times 0)</p>
<p class="p1"><span class="Apple-converted-space">        </span>(drop-first (rest lst) (- times 1))</p>
<p class="p1"><span class="Apple-converted-space">        </span>lst</p>
<p class="p1"><span class="Apple-converted-space">        </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define extract</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (i j lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(drop-last (drop-first lst i) (- (- (length lst) 1) j))</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define fill</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (n lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(if (&gt; n (length lst))</p>
<p class="p1"><span class="Apple-converted-space">        </span>(cons 0 (fill (- n 1) lst))</p>
<p class="p1"><span class="Apple-converted-space">        </span>lst</p>
<p class="p1"><span class="Apple-converted-space">        </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">; Some necessary binary conversion procedures</p>
<p class="p2"><br></p>
<p class="p1">(define bits-&gt;nonneg</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? lst) 0)</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (+ (* 2 (bits-&gt;nonneg (drop-last lst 1))) (first (reverse lst)))))))</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">(define nonneg-&gt;bits1</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (n)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((= n 0) '(0))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (append (nonneg-&gt;bits1 (quotient n 2)) (list (remainder n 2))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)))</p>
<p class="p2"><br></p>
<p class="p1">(define nonneg-&gt;bits</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (n)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((= n 0) '(0))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (rest (nonneg-&gt;bits1 n)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">; We will use sign-magnitude representation here for our binary</p>
<p class="p2"><br></p>
<p class="p1">(define bits-&gt;tcint<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (first lst) 1) (* (bits-&gt;nonneg (rest lst)) -1))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (first lst) 0) (bits-&gt;nonneg (rest lst))))))</p>
<p class="p2"><br></p>
<p class="p1">(define tcint-&gt;bits</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (x)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((or (&gt;= x 32768) (&lt;= x -32768)) '(overflow (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((&lt; x 0) (list 'ok (cons 1 (fill 15 (nonneg-&gt;bits (* x -1))))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((&gt;= x 0) (list 'ok (cons 0 (fill 15 (nonneg-&gt;bits (* x 1))))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">(define add-bits</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst1 lst2)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(tcint-&gt;bits (+ (bits-&gt;tcint lst1) (bits-&gt;tcint lst2)))))</p>
<p class="p2"><br></p>
<p class="p1">(define sub-bits</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst1 lst2)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(tcint-&gt;bits (- (bits-&gt;tcint lst1) (bits-&gt;tcint lst2)))))</p>
<p class="p2"><br></p>
<p class="p1">; We will make our assembly code in the form of a list</p>
<p class="p1">; Example of a list that initializes count to 1 and halts.</p>
<p class="p2"><br></p>
<p class="p1">(define prog1</p>
<p class="p1"><span class="Apple-converted-space">  </span>'((start: load one)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(store count)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(halt)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(one: data 1)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(count: data 0)))</p>
<p class="p2"><br></p>
<p class="p1">; Also we use labels in our assembly code</p>
<p class="p2"><br></p>
<p class="p1">(define label?</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (sym)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(let ((str (symbol-&gt;string sym)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(let ((char (string-ref str (- (string-length str) 1))))</p>
<p class="p1"><span class="Apple-tab-span">	</span>(equal? char #\:)))))</p>
<p class="p2"><br></p>
<p class="p1">(define remove-empty</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? lst) '())</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (first lst) '()) (remove-empty (rest lst)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (cons (first lst) (remove-empty (rest lst))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)))</p>
<p class="p2"><br></p>
<p class="p1">(define symbol-table</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (prog address)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? prog) '())</p>
<p class="p1"><span class="Apple-converted-space">      </span>((symbol? (first prog)) (if (label? (first prog))</p>
<p class="p1"><span class="Apple-converted-space">                                  </span>(list (first prog) address)</p>
<p class="p1"><span class="Apple-converted-space">                                  </span>'()))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((list? (first prog)) (remove-empty (append (list (symbol-table (first prog) address)) (symbol-table (rest prog) (+ address 1)))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else '())</p>
<p class="p1"><span class="Apple-converted-space">      </span>)))</p>
<p class="p2"><br></p>
<p class="p1">; (assemble) takes a symbolic program prog and</p>
<p class="p1">; a starting address, and returns the list of</p>
<p class="p1">; 16-bit values (represented as lists of bits)</p>
<p class="p1">; that represent that program<span class="Apple-converted-space"> </span></p>
<p class="p1">; when loaded *at that address*.</p>
<p class="p2"><br></p>
<p class="p1">; Examples (formatted for readability):</p>
<p class="p2"><br></p>
<p class="p1">; (assemble '((halt)) 3) =&gt;</p>
<p class="p1">; '((0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p2"><br></p>
<p class="p1">; (assemble '((data -1)) 0) =&gt;</p>
<p class="p1">; '((1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">; (assemble '((load 22) (store 23)) 0) =&gt;</p>
<p class="p1">; '((0 0 0 1 0 0 0 0 0 0 0 1 0 1 1 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 1 0 0 0 0 0 0 0 0 1 0 1 1 1))</p>
<p class="p2"><br></p>
<p class="p1">; (assemble prog2 0) =&gt;</p>
<p class="p1">; '((0 1 0 1 0 0 0 0 0 0 0 0 1 0 1 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 1 0 0 0 0 0 0 0 0 1 0 1 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 1 1 1 0 0 0 0 0 0 0 0 0 1 0 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(1 1 0 0 0 0 0 0 0 0 0 0 1 1 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 1 0 0 0 0 0 0 0 0 1 1 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 1 1 0 0 0 0 0 0 0 0 1 0 1 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 1 0 0 0 0 0 0 0 0 0 1 1 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 1 1 1 0 0 0 0 0 0 0 0 0 0 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 0 0 0 0 0 0 0 0 0 1 1 0 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p2"><br></p>
<p class="p1">(define prog2</p>
<p class="p1"><span class="Apple-converted-space">  </span>'((start: input val)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(load val)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(skipzero)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(jump continue)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(halt)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(continue: storei pointer)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(load pointer)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(add one)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(store pointer)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(jump start)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(one: data 1)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(val: data 0)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(pointer: data table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(table: data 0)))</p>
<p class="p2"><br></p>
<p class="p1">; Opcode Table</p>
<p class="p2"><br></p>
<p class="p1">(define op-table</p>
<p class="p1"><span class="Apple-converted-space">  </span>'((halt (0 0 0 0)) (load (0 0 0 1)) (store (0 0 1 0))</p>
<p class="p1"><span class="Apple-converted-space">    </span>(add (0 0 1 1)) (sub (0 1 0 0)) (input (0 1 0 1))</p>
<p class="p1"><span class="Apple-converted-space">    </span>(output (0 1 1 0)) (jump (0 1 1 1)) (skipzero (1 0 0 0))</p>
<p class="p1"><span class="Apple-converted-space">    </span>(skippos (1 0 0 1)) (skiperr (1 0 1 0)) (loadi (1 0 1 1))</p>
<p class="p1"><span class="Apple-converted-space">    </span>(storei (1 1 0 0)) (halt (1 1 0 1)) (halt (1 1 1 0))</p>
<p class="p1"><span class="Apple-converted-space">    </span>(halt (1 1 1 1))))</p>
<p class="p2"><br></p>
<p class="p1">; Some aux procedures to help convert</p>
<p class="p2"><br></p>
<p class="p1">(define convert</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (symbol)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(string-&gt;symbol (string-append (symbol-&gt;string symbol) ":"))))</p>
<p class="p2"><br></p>
<p class="p1">(define find-number</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (key lookup-table)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(left-lookup (convert key) lookup-table)))</p>
<p class="p2"><br></p>
<p class="p1">(define assemble</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (prog address)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(assemble-aux prog address (symbol-table prog address))))</p>
<p class="p2"><br></p>
<p class="p1">(define assemble-aux</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (prog address labels)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? prog) '())</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (length (first prog)) 1) (append (list (append (left-lookup (first (first prog)) op-table) '(0 0 0 0 0 0 0 0 0 0 0 0))) (assemble-aux (rest prog) address labels)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (list-ref (first prog) 1) 'data) (if (symbol? (list-ref (first prog) 2))</p>
<p class="p1"><span class="Apple-converted-space">                                                    </span>(append (list (list-ref (tcint-&gt;bits (find-number (list-ref (first prog) 2) labels)) 1)) (assemble-aux (rest prog) address labels))</p>
<p class="p1"><span class="Apple-converted-space">                                                    </span>(append (list (list-ref (tcint-&gt;bits (list-ref (first prog) 2)) 1)) (assemble-aux (rest prog) address labels))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (list-ref (first prog) 0) 'data) (if (symbol? (list-ref (first prog) 1))</p>
<p class="p1"><span class="Apple-converted-space">                                                    </span>(append (list (list-ref (tcint-&gt;bits (find-number (list-ref (first prog) 2) labels)) 1)) (assemble-aux (rest prog) address labels))</p>
<p class="p1"><span class="Apple-converted-space">                                                    </span>(append (list (list-ref (tcint-&gt;bits (list-ref (first prog) 1)) 1)) (assemble-aux (rest prog) address labels))))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (append (list (if (label? (first (first prog)))</p>
<p class="p1"><span class="Apple-converted-space">                </span>(append (left-lookup (list-ref (first prog) 1) op-table) (if (symbol? (list-ref (first prog) 2))</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>(drop-first (first (rest (tcint-&gt;bits (find-number (list-ref (first prog) 2) labels)))) 4)</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>(drop-first (first (rest (tcint-&gt;bits (list-ref (first prog) 2)))) 4)</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>)</p>
<p class="p1"><span class="Apple-converted-space">                        </span>)</p>
<p class="p2"><span class="Apple-converted-space">                        </span></p>
<p class="p1"><span class="Apple-converted-space">                </span>(append (left-lookup (list-ref (first prog) 0) op-table) (if (symbol? (list-ref (first prog) 1))</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>(drop-first (first (rest (tcint-&gt;bits (find-number (list-ref (first prog) 1) labels)))) 4)</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>(drop-first (first (rest (tcint-&gt;bits (list-ref (first prog) 1)))) 4)</p>
<p class="p1"><span class="Apple-converted-space">                                                                             </span>)</p>
<p class="p1"><span class="Apple-converted-space">                        </span>)</p>
<p class="p1"><span class="Apple-converted-space">                </span>))</p>
<p class="p1"><span class="Apple-converted-space">                    </span>(assemble-aux (rest prog) address labels)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><span class="Apple-converted-space">           </span></p>
<p class="p2"><br></p>
<p class="p1">; Next, we develop a simulator for the computer</p>
<p class="p2"><br></p>
<p class="p1">(define config1</p>
<p class="p1">'((acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(pc (0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(run-flag 1)<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(aeb 0)<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">  </span>(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))))</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">; ** problem 8 ** (9 points)</p>
<p class="p1">; The big procedure that takes a list of instructions insts (represented</p>
<p class="p1">; as a list of 16-bit lists) and a nonnegative</p>
<p class="p1">; integer memory address, and returns the configuration of</p>
<p class="p1">; the TC-201 with those instructions loaded into</p>
<p class="p1">; memory *starting at that address*, the accumulator</p>
<p class="p1">; zeroed, the program counter set to the address,</p>
<p class="p1">; the run-flag set to 1, and the arithmetic error bit set</p>
<p class="p1">; to 0.</p>
<p class="p2"><br></p>
<p class="p1">; Procedure to print a list</p>
<p class="p2"><br></p>
<p class="p1">(define print-lst</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">     </span>((null? lst) (newline) #t)</p>
<p class="p1"><span class="Apple-converted-space">     </span>(else (display (first lst)) (newline) (print-lst (rest lst))))))</p>
<p class="p2"><br></p>
<p class="p1">; These are the instructions: load 3, store 4:</p>
<p class="p2"><br></p>
<p class="p1">(define insts0</p>
<p class="p1"><span class="Apple-converted-space">   </span>'((0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1)</p>
<p class="p1"><span class="Apple-converted-space">     </span>(0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0)))</p>
<p class="p2"><br></p>
<p class="p1">; These are the instructions: load 8, store 9,</p>
<p class="p1">; halt, data 1, data 6.</p>
<p class="p2"><br></p>
<p class="p1">(define insts1</p>
<p class="p1"><span class="Apple-converted-space">  </span>'((0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 1)<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">    </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">    </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1)<span class="Apple-converted-space"> </span></p>
<p class="p1"><span class="Apple-converted-space">    </span>(0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0)))</p>
<p class="p2"><br></p>
<p class="p2"><span class="Apple-converted-space"> </span></p>
<p class="p1">; Examples</p>
<p class="p1">; (init-config insts0 0) =&gt;</p>
<p class="p1">; '((acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(pc (0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(run-flag 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(aeb 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0)))</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">; (init-config insts1 5) =&gt;<span class="Apple-converted-space"> </span></p>
<p class="p1">; '((acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(pc (0 0 0 0 0 0 0 0 0 1 0 1))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(run-flag 1)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(aeb 0)<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(5 (0 0 0 1 0 0 0 0 0 0 0 0 1 0 0 0))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(6 (0 0 1 0 0 0 0 0 0 0 0 0 1 0 0 1))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(7 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;<span class="Apple-converted-space">  </span>(8 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))<span class="Apple-converted-space"> </span></p>
<p class="p1">;<span class="Apple-converted-space">  </span>(9 (0 0 0 0 0 0 0 0 0 0 0 0 0 1 1 0)))</p>
<p class="p2"><br></p>
<p class="p1">(define flip</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (lst x)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((&gt; x 0) (flip (append (rest lst) (list (first lst))) (- x 1)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((= x 0) lst))))</p>
<p class="p2"><br></p>
<p class="p1">(define config-fixed</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (insts address)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(raw-config insts address address)))</p>
<p class="p2"><br></p>
<p class="p1">(define raw-config</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (insts address original)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((null? insts) (list '(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)) (cons 'pc (list (extract 4 15 (first (rest (tcint-&gt;bits original)))))) '(run-flag 1) '(aeb 0)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (cons (list address (first insts)) (raw-config (rest insts) (+ address 1) original))))))</p>
<p class="p2"><br></p>
<p class="p1">(define init-config</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (insts address)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(flip (config-fixed insts address) (length insts))))</p>
<p class="p2"><br></p>
<p class="p1">(define memory-read</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (address config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((not (equal? (left-lookup address config) #f)) (left-lookup address config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (left-lookup address config) #f) '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)))</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">(define memory-write</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (address contents config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(update (cons address (list contents)) config)))</p>
<p class="p2"><br></p>
<p class="p1">(define (sample-input)</p>
<p class="p1"><span class="Apple-converted-space">  </span>(display "input =")</p>
<p class="p1"><span class="Apple-converted-space">         </span>(read))</p>
<p class="p2"><br></p>
<p class="p1">(define pc-&gt;opcode</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(right-lookup (extract 0 3 (memory-read (bits-&gt;tcint (left-lookup 'pc config)) config)) op-table)))</p>
<p class="p2"><br></p>
<p class="p1">(define pc-&gt;opcodeaddress</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(bits-&gt;tcint (extract 4 15 (memory-read (bits-&gt;tcint (left-lookup 'pc config)) config)))))</p>
<p class="p2"><br></p>
<p class="p1">(define increment-pc</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cons 'pc (list (extract 4 15 (first (rest (add-bits '(0 0 0 0 1) (left-lookup 'pc config)))))))))</p>
<p class="p2"><br></p>
<p class="p1">(define execute</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (op address config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'halt) (update '(run-flag 0) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'load) (updates (list (cons 'acc (list (memory-read address config))) (increment-pc config)) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'store) (updates (list (cons address (list (left-lookup 'acc config))) (increment-pc config)) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'add) (if (equal? (first (add-bits (memory-read address config) (left-lookup 'acc config))) 'ok)</p>
<p class="p1"><span class="Apple-converted-space">                            </span>(updates (list (cons 'acc (rest (add-bits (memory-read address config) (left-lookup 'acc config)))) (increment-pc config) '(aeb 0)) config)</p>
<p class="p1"><span class="Apple-converted-space">                            </span>(updates (list (cons 'acc (rest (add-bits (memory-read address config) (left-lookup 'acc config)))) (increment-pc config) '(aeb 1)) config)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'sub) (if (equal? (first (sub-bits (memory-read address config) (left-lookup 'acc config))) 'ok)</p>
<p class="p1"><span class="Apple-converted-space">                            </span>(updates (list (cons 'acc (rest (sub-bits (left-lookup 'acc config) (memory-read address config)))) (increment-pc config) '(aeb 0)) config)</p>
<p class="p1"><span class="Apple-converted-space">                            </span>(updates (list (cons 'acc (rest (sub-bits (left-lookup 'acc config) (memory-read address config)))) (increment-pc config) '(aeb 1)) config)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'input) (updates (list (cons address (rest (tcint-&gt;bits (sample-input)))) (increment-pc config)) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'output) (display (string-append "output = " (number-&gt;string (bits-&gt;tcint (memory-read address config))) "\n")) (update (increment-pc config) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'jump) (update (cons 'pc (list (extract 4 15 (first (rest (tcint-&gt;bits address)))))) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'skipzero) (if (equal? (left-lookup 'acc config) '(0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(update (cons 'pc (list (extract 4 15 (first (rest (add-bits '(0 1) (first (rest (increment-pc config))))))))) config)</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(update (increment-pc config) config)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'skippos) (if (&gt; (bits-&gt;tcint (left-lookup 'acc config)) 0)</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(update (cons 'pc (list (extract 4 15 (first (rest (add-bits '(0 1) (first (rest (increment-pc config))))))))) config)</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(update (increment-pc config) config)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'skiperr) (if (&gt; (left-lookup 'aeb config) 0)</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(updates (list (cons 'pc (list (extract 4 15 (first (rest (add-bits '(0 1) (first (rest (increment-pc config))))))))) '(aeb 0)) config)</p>
<p class="p1"><span class="Apple-converted-space">                                 </span>(update (increment-pc config) config)))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'loadi) (updates (list (cons 'acc (list (memory-read (bits-&gt;tcint (memory-read address config)) config))) (increment-pc config)) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? op 'storei)(updates (list (cons (bits-&gt;tcint (memory-read address config)) (list (left-lookup 'acc config))) (increment-pc config)) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p1">; Get the next configuration from the current one</p>
<p class="p2"><br></p>
<p class="p1">(define next-config</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(cond</p>
<p class="p1"><span class="Apple-converted-space">      </span>((equal? (left-lookup 'run-flag config) 0) config)</p>
<p class="p1"><span class="Apple-converted-space">      </span>(else (execute (pc-&gt;opcode config) (pc-&gt;opcodeaddress config) config))</p>
<p class="p1"><span class="Apple-converted-space">      </span>)</p>
<p class="p1"><span class="Apple-converted-space">    </span>)</p>
<p class="p1"><span class="Apple-converted-space">  </span>)</p>
<p class="p2"><br></p>
<p class="p2"><br></p>
<p class="p1">; This is the procedure that makes it all work</p>
<p class="p2"><br></p>
<p class="p1">(define simulate</p>
<p class="p1"><span class="Apple-converted-space">  </span>(lambda (config steps)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(print-lst config)</p>
<p class="p1"><span class="Apple-converted-space">    </span>(if (&lt; steps 1)</p>
<p class="p1"><span class="Apple-tab-span">	</span>'steps-exhausted</p>
<p class="p1"><span class="Apple-tab-span">	</span>(simulate (next-config config) (- steps 1)))))</p>
<p class="p2"><br></p>
<p class="p1">; What happens when we run simulate?</p>
<p class="p2"><br></p>
<p class="p1">;&gt; (simulate config1 10)</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(run-flag 1)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;</p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(run-flag 1)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 1)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;</p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0s 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;</p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;</p>
<p class="p1">;(acc (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(pc (0 0 0 0 0 0 0 0 0 0 1 0))</p>
<p class="p1">;(run-flag 0)</p>
<p class="p1">;(aeb 0)</p>
<p class="p1">;(0 (0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 1))</p>
<p class="p1">;(1 (0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0))</p>
<p class="p1">;(2 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0))</p>
<p class="p1">;(3 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p1">;(4 (0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1))</p>
<p class="p2"><br></p>
<p class="p1">;'steps-exhausted</p>
</body>
</html>
