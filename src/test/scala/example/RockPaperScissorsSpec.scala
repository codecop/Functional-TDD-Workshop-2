package example

import org.scalatest._

class RockPaperScissorsSpec extends FlatSpec with Matchers {

  // Two players
  // One player will Win or it will be a draw --> Sum types?
  // We fix the agreement in a type

  // Entry points:
  // 1. Focusing on draw
  // 2. Focusing on winning

  // Winning -> What do we need to analyse?
  // S wins over P
  // R wins over S
  // P wins over R

  // win method on Scissors?
  //
//
//  "Scissors" should "win over paper" in {
//    val result = play(Scissors, Paper)
//    result shouldEqual Win(Scissors)
//  }
//
//  "Scissors" should "win over paper" in {
//    val result = play(playerOne=Scissors, playerTwo=Paper)
//    result shouldEqual PlayerOneWins
//  }

  "Scissors" should "win over paper" in {
    Scissors.winsOver(Paper) shouldEqual true
  }

  // General: Two different kind of risks: Implementation and business

  // TC: Paper wins over Rock
  // Triangulate over winsOver
  // Shaping types

  // TC: Introduce player as scissors winner
  // Go wider into scissors over paper
  // Risk based: Where do I see more uncertainty
  // More uncertain: Introduce player

  // Go to another entry point
  // TC: TBD
  // Not a good idea
  // Not continuing
  // Not finishing anything
  // Large decision tree
  // Loosing track where you want to go
  // DFS vs BFS

  // TC: Find a more abstract function: Hand wins over hand
  // Other view: Can I generalize the concept
  // Abstract representation for Scissors and Rock

  "Paper" should "not win over scissors" in {
    Paper.winsOver(Scissors) shouldEqual false
  }

  // I need an incentive to doubt my instincts
  // Mechanical approach: Go back to the rules
  // Rules of three: Recommendation?
  // I expect a pattern but I cannot see it
  // --> Ignorance is a bliss
  // Abstract later might be better: More evidence
  // Effort for refactoring might be high if abstracting early
  // abstract wins over

  sealed trait Hand {
    def winsOver(otherHand: Hand): Boolean
  }

  object Scissors extends Hand {
    def winsOver(paper: Hand) = true
  }

  object Paper extends Hand {
    def winsOver(scissors: Hand) = false
  }

}