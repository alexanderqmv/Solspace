// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract Vote
{
    // todo: startAt, endsAt [DURATION]
    struct Voter
    {
        bool isRegistered;
        bool hasVoted;
        uint votedProposalId;
    }
    struct Proposal
    {
        string name;
        uint voteCount;
    }
    address public owner;
    mapping(address => Voter) public voters;
    Proposal[] public proposals;
     /* @brief: инициализируем значения массива {proposals}. {voteCount} у всех {items} '0' [default] */

    
    constructor(string[] memory items)
    {
        owner = msg.sender;
        voters[owner].isRegistered = true;
        for (uint i = 0; i < items.length; ++i)
        {
            proposals.push(Proposal({
                name: items[i],
                 voteCount: 0
                }));
        }
    }

    function register(address user) public
    {
        require(owner == msg.sender, "Only owner can register users!");
        require(!voters[user].isRegistered, "Already registered!");
        voters[user].isRegistered = true;
    }

    function vote(uint proposalId) public 
    {
        Voter storage sender = voters[msg.sender];
        require(sender.isRegistered, "The sender is not registered!");
        require(!sender.hasVoted, "The sender has already voted.");
        sender.hasVoted = true;
        sender.votedProposalId = proposalId;
        proposals[proposalId].voteCount++;
    }

    


    function winner() public view returns(uint)
    {
        uint winnerId = 0;
        uint winnerVoteCount = 0;
        for (uint i = 0; i < proposals.length; ++i)
        {

            if (proposals[i].voteCount > winnerVoteCount)
            {
                winnerId = i;
                winnerVoteCount = proposals[i].voteCount;
            }
        }
        return winnerId;
    }
}  
