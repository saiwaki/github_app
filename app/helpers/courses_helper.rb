module CoursesHelper
  def line_class_name line
    if line.addition?
      "line line--addition"
    elsif line.deletion?
      "line line--deletion"
    else
      "line line--context"
    end
  end
  
  def github_diff_file_name file
    regexp = /^\/?dev\/null$/

    if regexp === file.a_path
      file.b_path
    else
      file.a_path
    end
  end
end
