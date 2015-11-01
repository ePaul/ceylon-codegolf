"""This function print the base-proof expressions for several example values
   and also calculate a score.
   
   Alternatively, it can generate a program which can be run to check if
   the expressions are actually correct.
   """
void scoreProofing(String proof(Integer n), Boolean generateChecker = false) {
    
    function getExpressionAndScore(Integer number) =>
        let (pr = proof(number)) [number, pr.size, pr];

    
    Integer printProof(Integer number, Integer score, String proof);
    
    if (generateChecker) {
        printProof = function(Integer number, Integer score, String proof) {
            print("    assert(``number`` == ``proof``);");
            return score;
        };
        print("shared void proofChecker() {");
    } else {
        printProof = function(Integer number, Integer score, String proof) {
            print(number.string.padLeading(5, ' ') + ": " + score.string.padLeading(3, ' ') + ": " + proof);
            return score;
        };
    }
    value limit = 1000;
    
    Integer score({Integer+} list) =>
            list.map(getExpressionAndScore).map(unflatten(printProof)).fold(0)(plus);
    
    value sumPos = score(1..limit);
    value averagePos = sumPos.float / limit;
    value sumNeg = score(0 .. -limit);
    value averageNeg = sumNeg.float / (limit + 1);
    value negWithBonus = averageNeg * 0.9;
    
    if (generateChecker) {
        print("""   print("everything okay!");""");
        print("}");
    } else {
        print("Total positive: ``sumPos``");
        print("Average positive: ``averagePos``");
        
        print("Total negative: ``sumNeg``");
        print("Average negative: ``averageNeg``");
        print("With bonus:``negWithBonus``");
        value totalScore = (negWithBonus + averagePos) / 2;
        print("Overall score: ``totalScore``");
    }
}
