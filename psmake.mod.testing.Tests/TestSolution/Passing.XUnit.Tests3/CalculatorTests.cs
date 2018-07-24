using Domain;
using Xunit;

namespace Passing.XUnit.Tests3
{
    public class CalculatorTests
    {
        [Fact]
        public void Calculator_should_multiply_two_values()
        {
            Assert.Equal(4.5m, new Calculator().Multiply(3, 1.5m));
        }
    }
}
