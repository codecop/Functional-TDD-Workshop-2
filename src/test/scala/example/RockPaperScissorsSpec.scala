package example

import org.scalatest._

class RockPaperScissorsSpec extends FlatSpec with Matchers {
  "The Hello object" should "say hello" in {
    Hello.greeting shouldEqual "hello"
  }


}
