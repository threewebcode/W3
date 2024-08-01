# Language Reference

If there is a main function in the crate, the crate may be not the executable crate. It the crate wants to be the executable crate, the main function must comply with some rules. It is not allowed to have input parameters.It is not permitted to have lifetime and trait bound. The crate can be compiled according to certain conditions. When the conditions are met, the crate is compiled. If the conditions are not met, some statements would not be included in the final output crate. 


