public class BadExample {

    private int unusedField;

    public BadExample() {
        // unnecessary constructor
    }

    public void DOStuff() {
        try {
            int FooBar = 1;
            System.out.println("Start");

            for (int i = 0; i < 30; i++) {
                System.out.println("Line " + i);
            }
        } catch (Exception e) {
            // silently ignored
        } finally {
            return; // forbidden in finally block
        }
    }
}

