namespace DotNet.Pipeline.Tests
{
    public class UnitTest1
    {
        [Fact]
        public void Test1()
        {

            // Act
            int result = 5 + 3;

            // Assert
            Assert.Equal(8, result);
        }
    }
}