package BlackFriday;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Reducer;

public class BlackFridayReducer extends Reducer<Text, DoubleWritable, Text, DoubleWritable>{
	
	@Override
	protected void reduce(Text key, Iterable<DoubleWritable> values, Context context)
			throws IOException, InterruptedException {
		int count=0;
		double averValue=0;
			for (DoubleWritable value : values) {
				averValue+=value.get();
				count++;
			}
			averValue /= count;
			context.write(key, new DoubleWritable(averValue));
	}
}
