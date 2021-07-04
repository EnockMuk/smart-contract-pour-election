pragma solidity ^0.8.4;


contract Election {
    
    
    
    address public admin;
    uint public id;
    uint public nombreDeVote;
    constructor(){
        
        admin=msg.sender;
    }
    
    
        //structuurer le candidat
        
        struct CANDIDAT {
            
            uint idcandidat;
            string nom;
            uint nbreVoix;
        }
        
        struct ELECTEUR {
            
            bool permit;
            bool djaVote;
            uint choix;
            
        }
        
        mapping(uint=>CANDIDAT)public candidats;
        mapping(address=>ELECTEUR)public electeurs;
        event Enregistrer(address indexed admin,string nom);
        event Autorisation(address indexed admin, address indexed electeur);
        event Vote(address indexed electeur,uint choix);
        function enregisterCandidat(string memory _nom)public {
            
            require(msg.sender==admin,"tu n'es pas admin");
            id+=1;
            candidats[id]=CANDIDAT(id,_nom,0);
            emit Enregistrer(msg.sender,_nom);
        }
        
        
        function autorisation(address _electeur)public {
            require(msg.sender==admin,"tu n'es ps admin");
            electeurs[_electeur].permit=true;
            emit Autorisation(msg.sender,_electeur);
            
        }
    
      function voter(uint _choix)public {
          require(msg.sender !=admin,"tu es admin ");
          require(electeurs[msg.sender].djaVote==false,"tu as dja vote");
          require(electeurs[msg.sender].permit==true,"tu n'es parmi electeurs");
          electeurs[msg.sender].choix=_choix;
          electeurs[msg.sender].djaVote==true;
          candidats[_choix].nbreVoix +=1;
          nombreDeVote+=1;
          emit Vote(msg.sender,_choix);
          
      }
    
    
    
}
