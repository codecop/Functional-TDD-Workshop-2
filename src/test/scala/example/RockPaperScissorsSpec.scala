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

  object Scissors {
    def winsOver(paper: Any) = true

  }

  object Paper
}
