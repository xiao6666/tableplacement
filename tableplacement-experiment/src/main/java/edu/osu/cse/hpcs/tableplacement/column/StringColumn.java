package edu.osu.cse.hpcs.tableplacement.column;

import org.apache.hadoop.hive.serde2.objectinspector.primitive.PrimitiveObjectInspectorFactory;
import org.apache.hadoop.hive.serde2.typeinfo.TypeInfo;

import edu.osu.cse.hpcs.tableplacement.TableProperty;

public class StringColumn extends Column<String> {

  public final static String STRING_LENGTH_STR = "length.string";
  public final static int DEFAULT_STRING_LENGTH = 30;

  private StringRandom random;

  public StringColumn(String name, TableProperty prop, TypeInfo typeInfo) {
    this(name, prop.getInt(STRING_LENGTH_STR, DEFAULT_STRING_LENGTH), typeInfo);
  }

  public StringColumn(String name, int length, TypeInfo typeInfo) {
    super(typeInfo);
    this.name = name;
    this.type = Column.Type.STRING;
    this.random = new StringRandom(length);
    this.hiveObjectInspector = PrimitiveObjectInspectorFactory.javaStringObjectInspector;
  }

  @Override
  public String nextValue() {
    // Generate a random string with characters chosen from the set of
    // alpha-numeric characters
    return random.nextValue();
  }

  @Override
  public String toString() {
    return "Column[name:" + name + ", type:" + type + ", random: "
        + random.toString() + "]";
  }

  @Override
  public String nextValueAsString() {
    return nextValue();
  }
}
