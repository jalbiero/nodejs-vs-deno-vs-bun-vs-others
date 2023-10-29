internal static class Primes {
    public static bool IsPrime(int num) {
        if (num <= 1) return false;
        if (num == 2) return true;
        if (num % 2 == 0) return false; // the only even prime is 2

        // Trial division (https://en.wikipedia.org/wiki/Prime_number#Trial_division)
        var limit = Math.Sqrt(num);

        for (int i=3; i<=limit; i++) {
            if (num % i == 0) return false;
        }

        return true;
    }

    public static IList<int> GetPrimesLessThan(int limit) {
        var result = new List<int>();

        for (int i=2; i<limit; i++) {
            if (IsPrime(i)) result.Add(i);
        }

        return result;
    }

    public static int CountPrimesLessThan(int limit) {
        int result = 0;

        for (int i=2; i<limit; i++) {
            if (IsPrime(i)) result++;
        }

        return result;
    }
}
