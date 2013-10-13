class RingBuffer // queue
{
  Line[] buf;
  int start;
  int end;

  RingBuffer(int sz)
  {
    buf = new Line[sz];
    start = 0;
    end = 0;
  }
  
  boolean isempty()
  {
    return start == end;
  }

  void clr()
  {
    start = 0;
    end = 0;
  }

  void push(Line val)
  {
    buf[end] = val;
    end = (end + 1) % buf.length;
  }
  
  Line pop()
  {
    Line val = buf[start];
    start = (start + 1) % buf.length;
    return val;
  }
}
