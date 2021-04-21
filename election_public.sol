pragma solidity ^0.7.0;


contract Election {
    
       string public nomelection=" Kinshasa Election edition 2022";
       address admin;
       uint public nombreDgensQuiontVote;
       uint public nombreDecandidats;
       constructor(){
           
           admin=msg.sender;
         
       }
       
       struct Candidat {
           
           string nom;
           string pnom;
           uint nombreDeVoix;
           
       }
       
       struct Processus {
           
           bool dejaVote;
           bool autorise;
           uint  choixDelecteur;
           
       }
       
       Candidat[]public candidats;
       mapping(address=>Processus)public electeurs;
       event AdressAutorise(address indexed administreur,address indexed autorisee);
       event AjouterCand(address indexed administreur,string nomCandidat, string pnomCandidat, uint voix);
       event VoteProcessus(address indexed electeur, uint choixFait);
       modifier adminAuto(){
           require(msg.sender==admin,"tu n'es pas l'admin");
           _;
       }
       
       
       function ajouterCandidat(string memory _nom,string memory _pnom)public adminAuto {
           
           candidats.push(Candidat(_nom,_pnom,0));
           candidats.push(Candidat(_nom,_pnom,0));
           emit AjouterCand(msg.sender,_nom,_pnom,0);
           nombreDecandidats++;
           
       }
       
       function autorisationDvote(address _add)public adminAuto{
           
           electeurs[_add].autorise=true;
           emit AdressAutorise(msg.sender,_add);
       }
      
       
       function voter(uint _choixDelecteur)public {
           require(electeurs[msg.sender].dejaVote==false,"tu as deja vote");
           require(electeurs[msg.sender].autorise==true,"tu n'es autorise de voter");
           electeurs[msg.sender].choixDelecteur=_choixDelecteur;
           electeurs[msg.sender].dejaVote=true;
           candidats[_choixDelecteur].nombreDeVoix++;
           nombreDgensQuiontVote++;
            emit VoteProcessus(msg.sender,_choixDelecteur);
           
       }
    
    
    
    
    
}
