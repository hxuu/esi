package com.acsi;

import org.springframework.stereotype.Service;

import java.util.*;

@Service
public class ChildService {
    private final Map<String, Child> children = new HashMap<>();

    public Child addChild(Child child) {
        children.put(child.getId(), child);
        return child;
    }

    public List<Child> getAllChildren() {
        return new ArrayList<>(children.values());
    }

    public Optional<Child> getChildById(String id) {
        return Optional.ofNullable(children.get(id));
    }

    public Optional<Child> updateChild(String id, Child updated) {
        if (children.containsKey(id)) {
            updated.setId(id);
            children.put(id, updated);
            return Optional.of(updated);
        }
        return Optional.empty();
    }

    public boolean deleteChild(String id) {
        return children.remove(id) != null;
    }
}

