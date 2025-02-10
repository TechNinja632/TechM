public class EnumEx {
    
    enum DaysOfWeek {
        MONDAY, TUESDAY, WEDNESDAY, THURSDAY, FRIDAY, SATURDAY, SUNDAY;
    }

    public static void main(String[] args) {
        
        printHolidayStatus(DaysOfWeek.MONDAY);
        printHolidayStatus(DaysOfWeek.SATURDAY);
        printHolidayStatus(DaysOfWeek.SUNDAY);
        printHolidayStatus(DaysOfWeek.WEDNESDAY);
    }

    
    public static void printHolidayStatus(DaysOfWeek day) {
        switch (day) {
            case SATURDAY:
            case SUNDAY:
                System.out.println(day + " - Holiday");
                break;
            default:
                System.out.println(day + " - Not Holiday");
        }
    }
}
