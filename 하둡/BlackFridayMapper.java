package BlackFriday;

import java.io.IOException;

import org.apache.hadoop.io.DoubleWritable;
import org.apache.hadoop.io.LongWritable;
import org.apache.hadoop.io.Text;
import org.apache.hadoop.mapreduce.Mapper;



public class BlackFridayMapper extends Mapper<LongWritable, Text, Text, DoubleWritable>{
	
	@Override
	protected void map(LongWritable key, Text value, Context context)
			throws IOException, InterruptedException {
		String line = value.toString();
		String[] items=line.split(",");
		String age = items[3];
		double purchase = Double.parseDouble(items[11]);
		context.write(new Text(age), new DoubleWritable(purchase));
	
	}

}
