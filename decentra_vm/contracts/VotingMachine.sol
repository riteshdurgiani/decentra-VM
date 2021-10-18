pragma solidity ^0.5.0;
//Specific version of solidity

contract VotingMachine{
    
    uint public totalVotes;
    uint public candidateCount;
    string public winner;
    struct Candidate{
        string candidateName;
        string partyName;
        uint voteCount;
        bool isWin;
        
    }
    mapping(uint => Candidate) public candidates;
    
    event CandidateAdded(string candidateName,string partyName,uint voteCount,uint candidateNo);
    event VoteCasted(uint candidateNo,string candidateName,string partyName);
    constructor() public {
        
        totalVotes = 0;
        candidateCount = 0;
        addCandidate("Ritesh","BJP");
        
    }
    
    function addCandidate(string memory _cName,string memory _pName) public {
        //add candidste to mapping 
       
        //increment candidate candidateCount
        uint _vcount =0;
         candidates[candidateCount++] = Candidate(_cName,_pName,_vcount,false);
        //emit event
        emit CandidateAdded(_cName,_pName,candidateCount - 1,_vcount);
        
        
    }
    
    function casteVote(uint _cId,string memory _candName,string memory _partName) public {
        totalVotes++;
        candidates[_cId].voteCount++;
        
        emit VoteCasted(_cId,_candName,_partName);
    }
    
    // function getWinner() public returns(string memory) {
    //     uint max = 0;
        
    //     for(uint i=0;i<candidateCount;i++){
    //         if(candidates[i].voteCount > max){
    //             max = candidates[i].voteCount;
    //             winner = candidates[i].partyName;
    //         }
    //     }
        
        
        
    //     return winner;
    // }
}
