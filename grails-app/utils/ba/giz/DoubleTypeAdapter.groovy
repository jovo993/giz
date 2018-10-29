package ba.giz

import com.google.gson.TypeAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonToken
import com.google.gson.stream.JsonWriter

class DoubleTypeAdapter extends TypeAdapter<Double> {

  @Override
  Double read(JsonReader reader) throws IOException {
    if (reader.peek() == JsonToken.NULL) {
      reader.nextNull()
      return null
    }

    String stringValue = reader.nextString()
    if(stringValue == "") {
      return 0.0
    }
    try {
      Double value = Double.valueOf(stringValue)
      return value
    } catch (NumberFormatException e) {
      return null
    }
  }

  @Override
  void write(JsonWriter writer, Double value) throws IOException {
    if (value == null) {
      writer.nullValue()
      return
    }
    writer.value(value)
  }
}