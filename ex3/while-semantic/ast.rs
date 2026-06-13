// Variable names are strings
pub type VarName = String;

// Arithmetic Expressions (AExp)
#[allow(dead_code)] // for Iand
#[derive(Debug, Clone)]
pub enum AExp {
    Num(i32),
    Var(VarName),
    Add(Box<AExp>, Box<AExp>),
    Mult(Box<AExp>, Box<AExp>),
    Sub(Box<AExp>, Box<AExp>),
    Iand(Box<AExp>, Box<AExp>),
    Shl(Box<AExp>, Box<AExp>), // x << y  =  x * 2^y
    Shr(Box<AExp>, Box<AExp>), // x >> y  =  floor(x / 2^y)
}

// Boolean Expressions (BExp)
#[allow(dead_code)] // for True, False, Beq, And
#[derive(Debug, Clone)]
pub enum BExp {
    True,
    False,
    Aeq(AExp, AExp),
    Beq(Box<BExp>, Box<BExp>),
    Gte(AExp, AExp),
    Neg(Box<BExp>),
    And(Box<BExp>, Box<BExp>),
}

// Statements (Stm)
#[derive(Debug, Clone)]
pub enum Stm {
    Ass(VarName, AExp),
    Skip,
    Comp(Box<Stm>, Box<Stm>),
    If(BExp, Box<Stm>, Box<Stm>),
    While(BExp, Box<Stm>),
    DoWhile(Box<Stm>, BExp), // do S while b
}







// ----------- Test Cases Functiond  --------
// let test1 = Skip;;
pub fn test1() -> Stm {
    Stm::Skip
}

// let test2 = Comp (Ass ("x", Num 3), Ass ("x", Add(Var "x", Num 1)));;
pub fn test2() -> Stm {
    Stm::Comp(
        Box::new(Stm::Ass("x".to_string(), AExp::Num(3))),
        Box::new(Stm::Ass(
            "x".to_string(),
            AExp::Add(
                Box::new(AExp::Var("x".to_string())),
                Box::new(AExp::Num(1)),
            ),
        )),
    )
}

// let test3 = If(Neg(Aeq(Var "x", Num 1)),Ass ("x", Num 3),Ass ("x", Num 7));;
pub fn test3() -> Stm {
    Stm::If(
        BExp::Neg(Box::new(BExp::Aeq(
            AExp::Var("x".to_string()),
            AExp::Num(1),
        ))),
        Box::new(Stm::Ass("x".to_string(), AExp::Num(3))),
        Box::new(Stm::Ass("x".to_string(), AExp::Num(7))),
    )
}

/*
let test4 = Comp (Ass("y", Num 1), 
    While(Neg(Aeq(Var "x", Num 0)),
        Comp(Ass("y", Mult(Var "y", Var "x")),
            Ass("x", Sub(Var "x", Num 1))
        )
    )
);;
*/
pub fn test4() -> Stm {
    Stm::Comp(
        Box::new(Stm::Ass("y".to_string(), AExp::Num(1))),
        Box::new(Stm::While(
            BExp::Neg(Box::new(BExp::Aeq(
                AExp::Var("x".to_string()),
                AExp::Num(0),
            ))),
            Box::new(Stm::Comp(
                Box::new(Stm::Ass(
                    "y".to_string(),
                    AExp::Mult(
                        Box::new(AExp::Var("y".to_string())),
                        Box::new(AExp::Var("x".to_string())),
                    ),
                )),
                Box::new(Stm::Ass(
                    "x".to_string(),
                    AExp::Sub(
                        Box::new(AExp::Var("x".to_string())),
                        Box::new(AExp::Num(1)),
                    ),
                )),
            )),
        )),
    )
}

// a := 84 ; b := 22 ; c := 0 ; while b != 0 do (a := a << 1 ; b := b >> 1)
// Expected: a = 2688, b = 0, c = 0
pub fn test5() -> Stm {
    Stm::Comp(
        Box::new(Stm::Ass("a".to_string(), AExp::Num(84))),
        Box::new(Stm::Comp(
            Box::new(Stm::Ass("b".to_string(), AExp::Num(22))),
            Box::new(Stm::Comp(
                Box::new(Stm::Ass("c".to_string(), AExp::Num(0))),
                Box::new(Stm::While(
                    BExp::Neg(Box::new(BExp::Aeq(
                        AExp::Var("b".to_string()),
                        AExp::Num(0),
                    ))),
                    Box::new(Stm::Comp(
                        Box::new(Stm::Ass(
                            "a".to_string(),
                            AExp::Shl(
                                Box::new(AExp::Var("a".to_string())),
                                Box::new(AExp::Num(1)),
                            ),
                        )),
                        Box::new(Stm::Ass(
                            "b".to_string(),
                            AExp::Shr(
                                Box::new(AExp::Var("b".to_string())),
                                Box::new(AExp::Num(1)),
                            ),
                        )),
                    )),
                )),
            )),
        )),
    )
}

// test6: do (x := x - 1) while (x >= 2)
// Starting from s3 (x=3): 3->2 (continue), 2->1 (stop)
// Expected: x = 1
pub fn test6() -> Stm {
    Stm::DoWhile(
        Box::new(Stm::Ass(
            "x".to_string(),
            AExp::Sub(
                Box::new(AExp::Var("x".to_string())),
                Box::new(AExp::Num(1)),
            ),
        )),
        BExp::Gte(AExp::Var("x".to_string()), AExp::Num(2)),
    )
}

// test7: x := 1 ; while !(x >= 128) do (x := x << 1)
// Expected: x = 128
pub fn test7() -> Stm {
    Stm::Comp(
        Box::new(Stm::Ass("x".to_string(), AExp::Num(1))),
        Box::new(Stm::While(
            BExp::Neg(Box::new(BExp::Gte(
                AExp::Var("x".to_string()),
                AExp::Num(128),
            ))),
            Box::new(Stm::Ass(
                "x".to_string(),
                AExp::Shl(
                    Box::new(AExp::Var("x".to_string())),
                    Box::new(AExp::Num(1)),
                ),
            )),
        )),
    )
}

// test8: x := 64 ; while !(x == 0) do (x := x >> 1)
// Expected: x = 0
pub fn test8() -> Stm {
    Stm::Comp(
        Box::new(Stm::Ass("x".to_string(), AExp::Num(64))),
        Box::new(Stm::While(
            BExp::Neg(Box::new(BExp::Aeq(
                AExp::Var("x".to_string()),
                AExp::Num(0),
            ))),
            Box::new(Stm::Ass(
                "x".to_string(),
                AExp::Shr(
                    Box::new(AExp::Var("x".to_string())),
                    Box::new(AExp::Num(1)),
                ),
            )),
        )),
    )
}