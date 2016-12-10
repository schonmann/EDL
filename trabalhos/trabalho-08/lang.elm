import Html exposing (text)

type alias Env = (String -> Int)

type Exp = Add Exp Exp | Sub Exp Exp | Mult Exp Exp | Div Exp Exp | Mod Exp Exp |
           Num Int | Var String | Const String |
           Not Exp | And Exp Exp | Or Exp Exp | Xor Exp Exp | Gt Exp Exp | Lt Exp Exp | Eql Exp Exp

type Prog = Attr String Exp
          | Seq Prog Prog
          | If Exp Prog Prog
          | While Exp Prog
          | Define String Exp


evalExp : Exp -> Env -> Int
evalExp exp env =
    case exp of
        ---------------------
        -- Numeric operations.
        ---------------------
        Add e1 e2   -> (evalExp e1 env) +  (evalExp e2 env)
        Sub e1 e2   -> (evalExp e1 env) -  (evalExp e2 env)
        Mult e1 e2  -> (evalExp e1 env) *  (evalExp e2 env)
        Div e1 e2   -> (evalExp e1 env) // (evalExp e2 env)
        Mod e1 e2   -> (evalExp e1 env) %  (evalExp e2 env)

        ---------------------
        -- Boolean operations.
        ---------------------

        Not e1      -> if (evalExp e1 env) == 0 then 1 else 0
        And e1 e2   -> if (evalExp e1 env /= 0) && (evalExp e2 env /= 0) then 1 else 0
        Or e1 e2    -> if (evalExp e1 env /= 0) || (evalExp e2 env /= 0)  then 1 else 0
        Xor e1 e2   -> if xor (evalExp e1 env /= 0) (evalExp e2 env /= 0)  then 1 else 0
        Gt e1 e2    -> if (evalExp e1 env) > (evalExp e2 env) then 1 else 0
        Lt e1 e2    -> if (evalExp e1 env) < (evalExp e2 env) then 1 else 0
        Eql e1 e2   -> if (evalExp e1 env) == (evalExp e2 env) then 1 else 0

        Num v       -> v
        Var var     -> (env var)
        Const const -> (env const)

evalProg : Prog -> Env -> Env
evalProg s env =
    case s of
        Seq s1 s2       -> (evalProg s2 (evalProg s1 env))
        Attr var exp    ->
            let val = (evalExp exp env)
            in \ask -> if ask == var then val else (env ask)
                
        If cond a b   -> if (evalExp cond env /= 0) then (evalProg a env)
                            else (evalProg b env)
        While cond a    -> if (evalExp cond env == 0) then env --Break.
                           else (evalProg (Seq a s) env)
        Define const exp ->
            let val = (evalExp exp env) -- If not defined, define.
            in if (env const) /= 0 then env -- Already defined, can't overwrite constant. 
               else \ask -> if ask == const then val else (env ask)

zero : Env
zero = \ask -> 0

lang : Prog -> Int
lang p = ((evalProg p zero) "ret")

p1 : Prog
p1 = (Attr "ret" (Add (Num 11) (Num 9)))

p2 : Prog
p2 = Seq    
        (Attr "x"   (Num 11))
        (Attr "ret" (Add (Var "x") (Num 9)))

p3 : Prog
p3 = Seq (Attr "x"   (Num 10)) --If/Equality test.
        (If (Eql (Var "b") (Num 0))
            (Attr "ret" (Num 1))
            (Attr "ret" (Num 0)))

main = text (toString (lang p2))