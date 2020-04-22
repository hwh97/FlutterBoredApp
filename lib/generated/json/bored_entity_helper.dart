import 'package:bored/models/bored_entity.dart';

boredEntityFromJson(BoredEntity data, Map<String, dynamic> json) {
	if (json['activity'] != null) {
		data.activity = json['activity']?.toString();
	}
	if (json['accessibility'] != null) {
		data.accessibility = json['accessibility']?.toString();
	}
	if (json['type'] != null) {
		data.type = json['type']?.toString();
	}
	if (json['participants'] != null) {
		data.participants = json['participants']?.toInt();
	}
	if (json['price'] != null) {
		data.price = json['price']?.toString();
	}
	if (json['link'] != null) {
		data.link = json['link']?.toString();
	}
	if (json['key'] != null) {
		data.key = json['key']?.toString();
	}
	return data;
}

Map<String, dynamic> boredEntityToJson(BoredEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['activity'] = entity.activity;
	data['accessibility'] = entity.accessibility;
	data['type'] = entity.type;
	data['participants'] = entity.participants;
	data['price'] = entity.price;
	data['link'] = entity.link;
	data['key'] = entity.key;
	return data;
}