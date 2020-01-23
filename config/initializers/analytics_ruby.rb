Analytics = Segment::Analytics.new({
    write_key: 'xDtqU87cXrnIeY7cvL2WSz4HBQhgNrCQ',
    on_error: Proc.new { |status, msg| print msg }
})
