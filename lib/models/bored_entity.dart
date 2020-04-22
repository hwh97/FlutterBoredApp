import 'package:bored/generated/json/base/json_convert_content.dart';

class BoredEntity with JsonConvert<BoredEntity> {
	String activity;
	String accessibility;
	String type;
	int participants;
	String price;
	String link;
	String key;

	@override
	bool operator ==(other) {
		return this.key == other.key;
	}
}
