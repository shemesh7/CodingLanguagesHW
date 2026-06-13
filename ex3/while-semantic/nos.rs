use crate::ast::*;
use crate::semantics::*;

// The main Natural Operational Semantics function:
// nos: (Stm, State) -> State
pub fn nos(c: (Stm, State)) -> State {
    let (stm, state) = c;

    match stm {
        // Assignment: [ass]
        Stm::Ass(x, e) => update(&x, &e, &state),

        // Skip: [skip]
        Stm::Skip => state,

        // Composition: [comp]
        Stm::Comp(s1, s2) => {
            let s_prime = nos((*s1, state));
            nos((*s2, s_prime))
        }

        // If: [if_tt] and [if_ff]
        Stm::If(b, s1, s2) => {
            if solve_b(&b, &state) == "tt" {
                nos((*s1, state))
            } else {
                nos((*s2, state))
            }
        }

        // While: [while_tt] and [while_ff]
        Stm::While(b, s_body) => {
            if solve_b(&b, &state) == "tt" {
                let s_prime = nos((*s_body.clone(), state));
                nos((Stm::While(b, s_body), s_prime))
            } else {
                state
            }
        }

        // [dowhile_tt_ns], [dowhile_ff_ns]:
        Stm::DoWhile(s_body, b) => {
            let s_prime = nos((*s_body.clone(), state));
            if solve_b(&b, &s_prime) == "tt" {
                nos((Stm::DoWhile(s_body, b), s_prime))
            } else {
                s_prime
            }
        }
    }
}