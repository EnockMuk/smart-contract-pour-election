pragma solidity ^0.7.0;

contract Vote {
        address admin;
        uint public npmbredevoix;
        uint public nombreDecandidat;
        string public kure="Election troisieme cycle RDC KINSHASA";
        uint candidatId;
        
        constructor(){
            
            admin= msg.sender;
        }
    
        struct CANDIDAT {
            
            string name;
            string lname;
            uint Nvoix;
            
        }
        struct VOTE {
            
            bool authorise;
            bool deJaVote;
            uint choixcandidat;
                 
        }
     
        CANDIDAT[]public candidat;
        mapping(address=>VOTE)public electeurs;
    
        function AjouterCandidat(string memory _name, string memory _lname)public {
            require(msg.sender==admin,"tu n'as pas le droit");
            candidatId++;
            candidat.push(CANDIDAT(_name,_lname,0));
            nombreDecandidat++;
        }
        
        function permission(address _add)public {
            require(msg.sender==admin,"tu n'as pas ce droit");
            electeurs[_add].authorise=true;
        }
        
        function matora(uint _choixCandidat)public {
            require(electeurs[msg.sender].deJaVote==false," you already vote, why do you want to cheat?");
            require(electeurs[msg.sender].authorise==true,"you don't have the right to vote");
            electeurs[msg.sender].choixcandidat=_choixCandidat;
            electeurs[msg.sender].deJaVote=true;
            candidat[_choixCandidat].Nvoix++;
            npmbredevoix++;
            
        }   
}