package db.util;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class ConvertDateUtil {

	// Timestamp <-> LocalDateTime
	public static LocalDateTime convertTimestampToLocalDateTime(Timestamp ts) {

		return ts.toLocalDateTime();
	}

	// LocalDateTime <-> Timestamp
	public static Timestamp convertLocalDateTimeToTimeStamp(LocalDateTime ldt) {

		return Timestamp.valueOf(ldt);

	}

	// String <-> LocalDateTime
	public static LocalDateTime convertStringToLocalDateTime(String str) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate ld = LocalDate.parse(str, dtf);
		LocalDateTime ldt = ld.atStartOfDay();
		return ldt;
	}

	public static LocalDateTime convertStringToLocalDateTime2(String str) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		LocalDate ld = LocalDate.parse(str, dtf);
		LocalDateTime ldt = ld.atStartOfDay();
		return ldt;
	}

	public static LocalDateTime convertStringToLocalDateTime3(String str) {

		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyyMMdd");
		LocalDate ld = LocalDate.parse(str, dtf);
		LocalDateTime ldt = ld.atStartOfDay();
		return ldt;
	}

	// LocalDateTime <-> String
	public static String convertLocalDateTimeToString(LocalDateTime ldt) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String result = ldt.format(dtf);
		return result;
	}

	public static String convertLocalDateTimeToString2(LocalDateTime ldt) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy/MM/dd");
		String result = ldt.format(dtf);
		return result;
	}

	// LocalDateTime <-> String
	public static String convertLocalDateTimeToString3(LocalDateTime ldt) {
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		String result = ldt.format(dtf);
		return result;
	}

}
