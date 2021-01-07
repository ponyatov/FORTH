#include "asm.hpp"

#ifdef ASM
int main(int argc, char *argv[]) {
    // check args: at least one source code file in .4th
    assert(argc>=2); args(argc,argv);
    // parse source code
    // FILE *src = fopen(argv[2],"r"); assert(src); yyinput(src); 
    yyparse();
    // always put final BYE
    CB(BYE);
    // write compiled
    FILE *img = fopen(argv[1],"wb"); assert(img);
    assert(fwrite(M,Cp,1,img)); fclose(img);
    // done
    printf("\n"); return 0;
}
#endif // ASM

void yyerror(const char *msg) {
    fprintf(stdout,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    fprintf(stderr,"\n\n%i: %s [%s]\n\n",yylineno,msg,yytext);
    exit(-1);
}

void CB(BYTE b) {                                   // Compile Byte
    M[Cp++] = b; assert(Cp<Msz);
}

void CC(CELL c) {                                   // Compile Cell
    *((CELL*)&M[Cp]) = c;               // only for little-endians
    Cp += sizeof(CELL); assert(Cp<Msz);
}

#include <map>
#include <vector>
std::map<std::string,CELL>                labels;   // known labels
std::map<std::string,std::vector<CELL>>   forward;  // fwd.refs

void CL(std::string* l, CELL a) {                   // Compile Label
    if (labels.find(*l) == labels.end()) {          // if label unknown
        if (forward.find(*l) == forward.end())      // update forwards:
             forward[*l] = std::vector<CELL>();     // new fwd.label, or
        forward[*l].push_back(a);                   // append to existing
        CC(-1);                                     // compile fake addr:-1
    } else
        CC(labels[*l]);                             // just compile it
}

void LL(std::string* l, CELL a) {                   // Add/Resolve Label
    if (labels.find(*l) == labels.end()) {
        labels[*l] = a;                             // append to known
        auto vec = forward.find(*l);                // scan for fwd[l]->addr[]
        if ( vec != forward.end()) {                // resolve forwards
            for (auto addr:vec->second)
                *((UCELL*)&M[addr]) = a;            // backpatch
            forward.erase(*l);                      // drop from fwd
        }
    } else
        yyerror(l->c_str());            // existing label redefinition
}
